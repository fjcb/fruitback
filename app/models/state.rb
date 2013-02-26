class State < ActiveRecord::Base
  attr_accessible :color, :name
  
  def self.form_states#(site)
    r = []
    State.all.each { |state|
      r.push [state.name, state.id]
    }
  end
  
end
