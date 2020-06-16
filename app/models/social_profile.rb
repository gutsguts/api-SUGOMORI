class SocialProfile < ApplicationRecord
  belongs_to :user
  # frozen_string_literal: true

  class SocialProfile < ActiveRecord::Base
    belongs_to :user
    store :other
    validates_uniqueness_of :uid, scope: :provider

    def set_values(omniauth)
      if provider.to_s != omniauth['provider'].to_s || uid != omniauth['uid']
        return
      end

      credentials = omniauth['credentials']
      info = omniauth['info']

      self.access_token = credentials['token']
      self.access_secret = credentials['secret']
      self.credentials = credentials.to_json
      self.email = info['email']
      self.name = info['name']
      self.nickname = info['nickname']
      self.description = info['description'].try(:truncate, 255)
      self.image_url = info['image']
      case provider.to_s

      when 'github'
        self.url = info['urls']['GitHub']
        other[:blog] = info['urls']['Blog']
      when 'google'
        self.nickname ||= info['email'].sub(/(.+)@gmail.com/, '\1')

      when 'twitter'
        self.url = info['urls']['Twitter']
        other[:location] = info['location']
        other[:website] = info['urls']['Website']
      end

      set_values_by_raw_info(omniauth['extra']['raw_info'])
    end

    def set_values_by_raw_info(raw_info)
      case provider.to_s
      when 'google'
        self.url = raw_info['link']
      when 'twitter'
        other[:followers_count] = raw_info['followers_count']
        other[:friends_count] = raw_info['friends_count']
        other[:statuses_count] = raw_info['statuses_count']
      end

      self.raw_info = raw_info.to_json
      save!
    end
  end
end
