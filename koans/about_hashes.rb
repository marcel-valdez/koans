require File.expand_path(File.dirname(__FILE__) + '/edgecase')

class AboutHashes < EdgeCase::Koan
  def test_creating_hashes
    empty_hash = Hash.new
    assert_equal Hash, empty_hash.class
    assert_equal({}, empty_hash)
    assert_equal 0, empty_hash.size
  end

  def test_hash_literals
    hash = { :one => "uno", :two => "dos" }
    assert_equal 2, hash.size
  end

  def test_accessing_hashes
    hash = { :one => "uno", :two => "dos" }
    assert_equal "uno", hash[:one]
    assert_equal "dos", hash[:two]
    # If the has does not exist, it returns nil
    assert_equal nil, hash[:doesnt_exist]
  end

  def test_accessing_hashes_with_fetch
    hash = { :one => "uno" }
    assert_equal "uno", hash.fetch(:one)
    assert_raise(KeyError) do
      # The difference between fetch and [] accesors for Hashes is that
      # fetch throws an exception if the key does not exist
      hash.fetch(:doesnt_exist)
    end

    # THINK ABOUT IT:
    #
    # Why might you want to use #fetch instead of #[] when accessing hash keys?
    # When you want to trow an exception if the value does not exist
  end

  def test_changing_hashes
    hash = { :one => "uno", :two => "dos" }
    hash[:one] = "eins"

    expected = { :one => "eins", :two => "dos" }
    assert_equal true, expected == hash
    # Bonus Question: Why was "expected" broken out into a variable
    # rather than used as a literal?
    # For readability, because a literal would've been fine. Look:
    assert_equal true, { :one => "eins", :two => "dos" } == hash
  end

  def test_hash_is_unordered
    hash1 = { :one => "uno", :two => "dos" }
    hash2 = { :two => "dos", :one => "uno" }

    # Hashes are equal independently of order
    assert_equal true, hash1 == hash2
  end

  def test_hash_keys
    hash = { :one => "uno", :two => "dos" }
    assert_equal 2, hash.keys.size
    assert_equal true, hash.keys.include?(:one)
    assert_equal true, hash.keys.include?(:two)
    # Hash.keys returns an Array of Symbols
    assert_equal Array, hash.keys.class
  end

  def test_hash_values
    hash = { :one => "uno", :two => "dos" }
    assert_equal 2, hash.values.size
    assert_equal true, hash.values.include?("uno")
    assert_equal true, hash.values.include?("dos")
    # Hash.values also returns an array
    assert_equal Array, hash.values.class
  end

  def test_combining_hashes
    hash = { "jim" => 53, "amy" => 20, "dan" => 23 }
    new_hash = hash.merge({ "jim" => 54, "jenny" => 26 })

    assert_equal true, hash != new_hash

    expected = { "jim" => __, "amy" => 20, "dan" => 23, "jenny" => __ }
    assert_equal false, expected == new_hash
  end

  def test_default_value
    hash1 = Hash.new
    hash1[:one] = 1

    assert_equal 1, hash1[:one]
    assert_equal nil, hash1[:two]

    hash2 = Hash.new("dos")
    hash2[:one] = 1

    assert_equal 1, hash2[:one]
    # The parameter for a new has is the default value of inexistent keys
    assert_equal "dos", hash2[:two]
  end

  def test_default_value_is_the_same_object
    hash = Hash.new([])

    # The default value is stored in the hash and can be changed
    # it is mutable and replaceable
    hash[:one] << "uno"
    hash[:two] << "dos"

    assert_equal ["uno", "dos"], hash[:one]
    assert_equal ["uno", "dos"], hash[:two]
    assert_equal ["uno","dos"], hash[:three]

    assert_equal true, hash[:one].object_id == hash[:two].object_id
  end

  def test_default_value_with_block
    hash = Hash.new {|hash, key| hash[key] = [] }

    # when a block is passed, the block is executed prior to the access of the key
    hash[:one] << "uno"
    hash[:two] << "dos"

    # in this case, an array is created, therefore equality has to be for an array
    # since the << operator appends a value to an array
    assert_equal ["uno"], hash[:one]
    assert_equal ["dos"], hash[:two]
    assert_equal [], hash[:three]
  end
end
