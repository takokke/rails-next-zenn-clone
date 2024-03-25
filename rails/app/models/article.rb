class Article < ApplicationRecord
    belongs_to :user
    enum :status, { unsaved: 10, draft: 20, published: 30 }, _prefix: true

    # self.publised? == true のみ、titleとcontentが空であってはならない
    validates :title, :content, presence: true, if: :published?
    # プライベートメソッド
    validate :verify_only_one_unsaved_status_is_allowed

    private

    # 未保存記事を他に保有しているとき、その記事を未保存状態で登録できない
    def verify_only_one_unsaved_status_is_allowed
        if unsaved? && user.articles.unsaved.present?
            raise StandardError, "未保存の記事は複数保有できません"
        end
    end
end
