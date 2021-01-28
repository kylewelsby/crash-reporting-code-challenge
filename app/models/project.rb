class Project < ApplicationRecord
  include Redis::Objects
  counter :invalid_count
  counter :error_count
  counter :warning_count
  counter :info_count
end
