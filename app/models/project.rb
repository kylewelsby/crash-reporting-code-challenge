class Project < ApplicationRecord
  include Redis::Objects
  counter :invalid
end
