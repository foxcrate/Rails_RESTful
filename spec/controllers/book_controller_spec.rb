require "rails_helper"

RSpec.describe Api::V1::BooksController, type: :controller do
  it 'has a maximum limit of 100' do
    expect(Book).to receive(:limit).with(100).and_call_original
    # p Book

    get :index,params: {limit: 120}
  end
end

