require 'rails_helper'

describe 'Books API' , type: :request do
    it 'returns all books' do
        get '/api/v1/books'
        expect(response).to have_http_status(:success)
        p "--first test --"
        expect(JSON.parse(response.body).size).to eq(5)
    end

    it 'returns a subset of books based on pagination' do
        get '/api/v1/books' ,params: {limit: 1, offset: 1}
        p "-- second test --"
        expect(response).to have_http_status(:success)
        parsed_body = JSON.parse(response.body)
        # p "-- parsed_body: "+parsed_body.size.to_s+" --"
        expect(parsed_body.size).to eq(1)
        expect(parsed_body).to eq([
            # {
            #     "id"=> 1,
            #     "title"=> "elfel",
            #     "writer"=>"musrad",
            #     "created_at"=> "2020-12-03T00:00:00.000Z",
            #     "updated_at"=> "2020-12-02T00:00:00.000Z"
            #   },
              {
                "id" => 2,
                "title" => "elfel2",
                "writer" => "murad",
                "created_at" => "2020-01-01T00:00:00.000Z",
                "updated_at" => "2020-02-02T00:00:00.000Z"
              }
        ])
    end


end