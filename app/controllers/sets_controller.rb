
# vim: ts=2 sw=2 expandtab

class SetsController < ApplicationController
  def definition
  end
  def view
    case params[:commit]
    when "union"
      union
    when "intersection"
     intersection
    when "difference"
      difference
    when "subset"
      subset
    end
  end
  def union
    # Initialize empty set
    setUnion = Hash.new

    # Convert user input (lists) to sets
    lisa = params[:seta]
    lisb = params[:setb]
    lisa.each do |k|
      setUnion[k] = true
    end
    lisb.each do |k|
      setUnion[k] = true
    end

    @output = setUnion.keys
  end
  def intersection
    # Initialize empty set for result
    setIntersection = Hash.new

    # Collect user input lists
    lisa = params[:seta]
    lisb = params[:setb]

    # Add set A items to intermediate hashmap
    hasha = Hash.new
    lisa.each do |k|
      hasha[k] = true
    end

    # Iterate over set B, adding any key found
    # in hash A to the final result
    lisb.each do |k|
      if hasha.key?(k)
        setIntersection[k] = true
      end
    end

    @output = setIntersection.keys
  end
  def difference
    # Initialize empty set for result
    setDifference = Hash.new

    # Initialize empty set for union
    setIntersection = Hash.new

    # Collect user input lists
    lisa = params[:seta]
    lisb = params[:setb]

    # Add set A items to intermediate hashmap
    hasha = Hash.new
    lisa.each do |k|
      hasha[k] = true
    end

    # Iterate over set B, adding any key found
    # in hash A to the final result
    lisb.each do |k|
      if hasha.key?(k)
        setIntersection[k] = true
      end
    end

    # Add set items which aren't in intersection to difference
    (lisa + lisb).each do |k|
      if not setIntersection.key?(k)
        setDifference[k] = true
      end
    end

    @output = setDifference.keys
  end
  def subset
    # Collect user input lists
    lisa = params[:seta]
    lisb = params[:setb]

    # Add set B items to intermediate hashmap
    hashb = Hash.new
    lisb.each do |k|
      hashb[k] = true
    end

    # Optimism: assume A is a subset
    aIsSubsetOfB = true
    lisa.each do |k|
      if not hashb.key?(k)
        aIsSubsetOfB = false
        break
      end
    end

    @output = aIsSubsetOfB ? ["true"] : ["false"]

  end

  # Route to dump results for manual testing
  def temp
    puts YAML::dump params[:seta]
    puts YAML::dump params[:setb]
    render plain: params[:seta].inspect
  end

end
