class Message < ApplicationRecord
    belongs_to :chat
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    index_name Rails.application.class.parent_name.underscore
    document_type self.name.downcase

    settings index: { number_of_shards: 1 } do
        mapping dynamic: false do
          indexes :chat_number, type: :integer
          indexes :body, analyzer: 'english'
        end
    end

    def self.search(query)
        __elasticsearch__.search(
        {
          query: {
             multi_match: {
               query: ".*#{query}.*",
               fields: ['chat_number^5', 'body']
             }
           },
           # more blocks will go IN HERE. Keep reading!
        }
        )
    end
      
end
