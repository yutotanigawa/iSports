class Team < ApplicationRecord
    belongs_to :user
    belongs_to :genre
    has_many :bookmarks, dependent: :destroy
    has_many :users, through: :bookmarks
    attachment :team_image

    #GoogleMapAPIにて住所を登録するカラム名
    geocoded_by :address
    after_validation :geocode, :if => :address_changed?

    def bookmark_by?(user)
        bookmarks.where(user_id: user.id).exists?
    end

    enum prefecture: {
        北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
        茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
        新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
        岐阜県:21,静岡県:22,愛知県:23,三重県:24,
        滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
        鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
        徳島県:36,香川県:37,愛媛県:38,高知県:39,
        福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,沖縄県:47
    }

    #  enum day_of_week: {
    #      日曜:0,月曜:1,火曜:2,水曜:3,木曜:4,金曜:5,土曜:6, 未定:7
    #  }

    #活動頻度のenum
    enum frequency: {
        月に1〜2回程度:0,週に1〜２回程度:1,週に3〜毎日:2,不定期:3
    }
    #申請状況のenum
    enum publication_status: {
        applying:0, permission:1, is_deleted:2
    }

    #都道府県による絞り込み
    scope :get_by_prefecture, ->(prefecture) {
        where(prefecture: prefecture)
        }
    #活動頻度による絞り込み
    scope :get_by_frequency, ->(frequency) {
        where(frequency: frequency)
        }

    #ジャンルによる絞り込み
    scope :get_by_genre_id, ->(genre_id) {
        where(genre_id: genre_id)
        }

    #活動曜日による絞り込み
    scope :get_by_day_of_week, ->(day_of_week) {
        where("day_of_week like?", "%#{day_of_week}%")
        }

    #掲載状況による絞り込み
    scope :get_by_publication_status, ->(publication_status) {
        where(publication_status: publication_status)
        }
end
