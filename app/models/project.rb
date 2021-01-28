class Project < ApplicationRecord
  include Redis::Objects
  counter :invalid_count
end
