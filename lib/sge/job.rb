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
    ATTRIBUTES.each do |k,v|
      alias_method k, v
      alias_method "#{k}=", "#{v}="
    end

    def self.from_document(doc)
      instance = new
      doc.xpath('.//' + ATTRIBUTES_PATH ).each do |node|
        instance.send("#{node.name}=", node.text)
      end
      instance
    end

  end
end
