require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "validations" do
    context 'published' do
      before { allow(subject).to receive(:published?).and_return(true) }
      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:body) }
      it { should validate_presence_of(:publish_date) }
      it { should validate_attached_of(:image) }
    end

    it { should validate_content_type_of(:image).allowing('image/png', 'image/jpg', 'image/jpeg') }
    it { should validate_dimensions_of(:image).width_between(60..2400) }
    it { should validate_dimensions_of(:image).height_between(60..2400) }
  end

  describe "scopes" do
    let!(:post1) { create(:post, :with_image, publish_date: 2.days.ago, published: true) }
    let!(:post2) { create(:post, publish_date: 1.day.ago, published: false) }
    let!(:post3) { create(:post, :with_image, publish_date: Date.today, published: true) }

    describe ".index_page" do
      subject { described_class.index_page }

      it { is_expected.to include(post1) }
      it { is_expected.not_to include(post2) }
      it { is_expected.not_to include(post3) }
    end

    describe ".main_page" do
      let!(:post1) { create(:post, :with_image, on_main_page: true, publish_date: 2.days.ago, published: true) }
      let!(:post2) { create(:post, :with_image, on_main_page: false, publish_date: 1.day.ago, published: true) }

      subject { described_class.main_page }

      it { is_expected.to include(post1) }
      it { is_expected.not_to include(post2) }
    end
  end
  
  describe "#published?" do
    let(:post) { build(:post, published: true) }

    it "returns the value of the 'published' field" do
      expect(post.published?).to be true
    end
  end

  describe "#publish" do
    let(:post) { create(:post) }

    it "sets the 'published' field to true" do
      post.publish
      expect(post.published).to be true
    end

    it "returns false if the post could not be saved" do
      allow(post).to receive(:save).and_return(false)
      expect(post.publish).to be false
    end
  end
end
