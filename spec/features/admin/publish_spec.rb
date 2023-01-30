require 'rails_helper'

feature 'Administrator can publish post which is ready to be published' do
  let(:admin) { create(:admin) }
  let!(:post) { create(:post) }
  
  before { sign_in(admin) } 

  scenario 'can not publish invalid post' do
    visit admin_post_path(post)

    click_on 'Опубликовать'
    expect(page).to have_content "Image can't be blank" 
  end

  scenario 'can publish valid post' do
    post.image.attach(io: File.open(Rails.root.join('spec', 'support', 'logo.jpg')), 
                      filename: 'logo.jpg')
    
    visit admin_post_path(post)
    click_on 'Опубликовать'
    visit posts_path
    expect(page).to have_content post.title 
  end
end