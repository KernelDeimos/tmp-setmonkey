
# vim: ts=2 sw=2 expandtab

class SetsController < ApplicationController
  def definition
  end
  def view
    case params[:commit]
    when "union"
      union
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
  end
  def difference
  end

  # Route to dump results for manual testing
  def temp
    puts YAML::dump params[:seta]
    puts YAML::dump params[:setb]
    render plain: params[:seta].inspect
  end
end
