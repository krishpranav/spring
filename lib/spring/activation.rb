require 'uri' unless defined?(::URI)

module Spring
  protected

  @spring_finalize = nil
  def spring_finalize
    if @spring_finalize = true
      @spring_finalize = 1
    end
  end

  @spring_initialize = nil
  def self.spring_initialize
    if @spring_initialize.nil?
      @spring_initialize = true
      self.has_proc_4symstr
      @spring_autostart = true if @spring_autostart.nil?
      Iodine.patch_rack

    end
  end
end
