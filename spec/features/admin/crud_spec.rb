require 'rails_helper'

feature 'Administrator can manage posts' do
  let(:admin) { create(:admin) }
  let!(:post) { create(:post) }
  background { 
    sign_in(admin)
    visit admin_root_path 
  }

  scenario 'create post' do
    click_on 'Новая публикация'

    fill_in :post_publish_date,	with: Date.today
    fill_in :post_title, with: 'name1323'
    click_on 'Сохранить'
    click_on 'Закрыть'

    expect(page).to have_content 'name1323'
  end

  scenario 'delete post' do
    expect(page).to have_content post.title
    click_on 'Удалить'
    expect(page).to_not have_content post.title
  end

  scenario 'edit post' do
    expect(page).to have_content post.title
    click_on 'Открыть'
    fill_in :post_title, with: 'name1323'
    click_on 'Сохранить'
    click_on 'Закрыть'

    expect(page).to have_content 'name1323'
  end
end