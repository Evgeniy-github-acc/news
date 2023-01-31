require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "validations" do
    context 'published' do
      before { allow(subject).to receive(:published?).and_return(true) }
      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:body) }
      it { should validate_attached_of(:image) }
    end

    it { should validate_presence_of(:publish_date) }
    it { should validate_content_type_of(:image).allowing('image/png', 'image/jpg', 'image/jpeg') }
  end

  describe "scopes" do
    let!(:post1) { create(:post, :with_image, publish_date: 2.days.ago, published: true) }
    let!(:post2) { create(:post, publish_date: 1.day.ago, published: false) }
    let!(:post3) { create(:post, :with_image, publish_date: Date.today, published: true) }

    describe ".index_page" do
      subject { described_class.index_page }

      it { is_expected.to include(post1) }
      it { is_expected.not_to include(post2) }
      it { is_expected.to include(post3) }
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

  describe ".for_main_page" do
    let!(:post0) { create(:post, :with_image, on_main_page: true, publish_date: 3.day.ago, published: true) }
    let!(:post1) { create(:post, :with_image, on_main_page: true, publish_date: 2.days.ago, published: true) }
    let!(:post2) { create(:post, :with_image, on_main_page: true, publish_date: 1.day.ago, published: true) }
    let!(:post3) { create(:post, :with_image, on_main_page: false, publish_date: Date.today, published: true) }
    
        
    it "returns the first 3 posts from .main_page if the number of posts is greater than or equal to 3" do
      expect(described_class.for_main_page).to eq([post2, post1, post0])
    end
    
    it "returns the first 3 posts from .index_page if the number of posts in .main_page is less than 3" do
      allow(described_class).to receive(:main_page).and_return([])
      expect(described_class.for_main_page).to eq([post3, post2, post1])
    end
  end
end
