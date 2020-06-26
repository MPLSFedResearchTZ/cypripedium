# frozen_string_literal: true
require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe 'When displaying a collection, sort by issue number', type: :system, clean: true, js: true do
  let(:admin_user) { FactoryBot.create(:admin) }
  let(:collection) do
    coll = Collection.new(
      title: ['Collection 1'],
      collection_type: Hyrax::CollectionType.find_or_create_default_collection_type,
      description: ['My amazing collection']
    )
    coll.apply_depositor_metadata(admin_user.user_key)
    coll.save!
    coll
  end
  let(:collection_members) do
    [5, 4, 3, 2, 1].each do |i|
      p = FactoryBot.create(:publication, issue_number: [i.to_s], depositor: admin_user.user_key)
      p.member_of_collections << collection
      p.save
    end
  end

  before do
    collection_members
    AdminSet.find_or_create_default_admin_set_id
    login_as admin_user
  end

  context 'order the items in a collection' do
    it 'shows the works sorted by issue number descending when the page first loads' do
      visit Hyrax::Engine.routes.url_helpers.collection_path(collection.id)
      expect(page.find(:xpath, '/HTML/BODY[1]/DIV[3]/DIV[1]/DIV[7]/TABLE[1]/TBODY[1]/TR[1]/TD[3]').text). to eq "5"
      expect(page.find(:xpath, '/HTML/BODY[1]/DIV[3]/DIV[1]/DIV[7]/TABLE[1]/TBODY[1]/TR[5]/TD[3]').text). to eq "1"
    end
  end
end