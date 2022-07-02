module AresMUSH
  class PendragonTraits < Ohm::Model
    include ObjectModel
    
    reference :character, "AresMUSH::Character"
    attribute :name
    attribute :rating, :type => DataType::Integer, :default => 10
    attribute :opposite
    attribute :opp_rating, :type => DataType::Integer, :default => 10
    index :name

  end
end
