
class Actor
  attr_reader :name
  attr_reader :film_actor_hash

  def initialize(name, hash)
    @name = name
    @film_actor_hash = hash
  end
end
