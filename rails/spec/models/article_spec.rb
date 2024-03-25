require "rails_helper"

RSpec.describe Article, type: :model do
  context "factoryのデフォルト設定に従った場合" do
    subject { create(:article) }

    it "正常にレコードを新規作成できる" do
      expect { subject }.to change { Article.count }.by(1)
    end
  end

  describe "Validations" do
    subject { article.valid? }

    let(:article) { build(:article, title:, content:, status:, user:) }
    let(:title) { Faker::Lorem.sentence }
    let(:content) { Faker::Lorem.paragraph }
    let(:status) { :published }
    let(:user) { create(:user) }

    context "全ての値が正常な場合" do
      it "検証が通る" do
        expect(subject).to be_truthy
      end
    end

    context "タイトルが空かつ、ステータスが公開" do
      let(:title) { "" }

      it "エラーメッセージがくる" do
        expect(subject).to be_falsy
        expect(article.errors.full_messages).to eq ["タイトルを入力してください"]
      end
    end

    context "本文が空かつ、ステータスが公開" do
      let(:content) { "" }

      it "エラーメッセージがくる" do
        expect(subject).to be_falsy
        expect(article.errors.full_messages).to eq ["本文を入力してください"]
      end
    end

    context "ステータスが未保存かつ、すでに同一ユーザーが未保存ステータスの記事を所有していた時" do
      let(:status) { :unsaved }
      before { create(:article, status: :unsaved, user:) }

      it "例外が発生する" do
        expect { subject }.to raise_error(StandardError)
      end
    end
  end
end
