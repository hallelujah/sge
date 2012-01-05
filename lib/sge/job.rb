module SGE
  class Job
    ATTRIBUTES = {
      :JB_job_number => :job_number,
      :JAT_prio => :priority,
      :JB_name => :name,
      :JB_owner => :owner,
      :JAT_start_time => :start_time,
      :queue_name => :queue_name,
      :slots => :slots,
      :state => :state
    }
    
    ATTRIBUTES_PATH = ATTRIBUTES.keys.join('|')
    
    attr_accessor *ATTRIBUTES.values
    
    def self.from_document(doc)
      instance = new
      doc.xpath('.//' + ATTRIBUTES_PATH ).each do |node|
        instance.set(ATTRIBUTES[node.name.to_sym], node.text)
      end
      instance
    end
    
    def set(k,v)
      instance_variable_set("@#{k.to_s}", v)
    end
  end
end