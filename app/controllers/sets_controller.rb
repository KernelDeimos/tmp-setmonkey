
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
    end
    render :view
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

    # Convert user input (lists) to sets
    lisa = params[:seta]
    lisb = params[:setb]

    # Add set A items to intermediate hashmap
    hasha = Hash.new
    lisa.each do |k|
      hasha[k] = true
    end

    # Iterate over set B, adding any key not found
    # in hash A to the final result
    lisb.each do |k|
      if hasha.key?(k)
        setIntersection[k] = true
      end
    end

    @output = setIntersection.keys
  end
  def difference
  end
  def subset
  end

  # Route to dump results for manual testing
  def temp
    puts YAML::dump params[:seta]
    puts YAML::dump params[:setb]
    render plain: params[:seta].inspect
  end
end
