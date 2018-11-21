class LineBotEvent
  include Mongoid::Document
  field :body

  def body=(object)
    write_attribute(:body, object_to_hash(object))
  end

  private
  def object_to_hash(object)
    object.instance_variables.each_with_object({}) { |var, hash| hash[var.to_s.delete("@")] = object.instance_variable_get(var) }
  end
end
