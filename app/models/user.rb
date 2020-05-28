class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

         has_many :messages, dependent: :destroy
         has_many :entries, dependent: :destroy
         has_many :teams, dependent: :destroy
         has_many :bookmarks, dependent: :destroy
         has_many :bookmark_teams, through: :bookmarks, source: :team
         attachment :profile_image


        # バリデーションの設定
        validates :name, length: {in: 2..15}
        validates :gender_status, presence: true
        validates :birth_date, presence: true

        #ユーザーidがチームを保持しているユーザーのidと一致する場合
        def own_teams?(teams)
          self.id == teams.user_id
        end

      #   #Facebookによるユーザー認証
      #   def self.find_for_oauth(auth)
      #     user = User.where(uid: auth.uid, provider: auth.provider).first
      #     unless user
      #      user = User.new(
      #        uid: auth.uid,
      #        provider: auth.provider,
      #        email: auth.info.email,
      #        password: Devise.friendly_token[0, 20]
      #      )
      #     if user.save
      #       p "success"
      #     else
      #       p "failed"
      #       p user.errors
      #     end
      #    end
      #    user
      # end

        #Userモデルの各enum使用カラム
        enum valid_status: { active: 0, is_deleted: 1}
        enum gender_status: { male: 0, female: 1}
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

        #生年月日から年齢を算出しageクラスとする
        attr_accessor :age
        def age
          d2=self.birth_date.strftime("%Y%m%d").to_i
          d1=Date.today.strftime("%Y%m%d").to_i
          return (d1 - d2) / 10000
        end


        #性別による絞り込み
        scope :get_by_gender_status, ->(gender_status) {
        where(gender_status: gender_status)
        }
        #都道府県による絞り込み
        scope :get_by_prefecture, ->(prefecture) {
        where(prefecture: prefecture)
        }

        #会員ステータスによる絞り込み
        scope :get_by_valid_status, ->(valid_status) {
        where(valid_status: valid_status)
        }

        #論理削除による退会機能
        def withdraw!
          if active?
            is_deleted!
          else
            active!
          end
        end

        def active_for_authentication?
          super && self.valid_status == "active"
        end
end
