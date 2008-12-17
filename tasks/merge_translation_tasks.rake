namespace :translations do
  desc "Merges the default locale into another locale"
  task :merge, [:locale, :default, :path] => :environment do |t, args|
    args.with_defaults(:path => RAILS_ROOT + '/config/locales', :locale => "", :default => "en-US")
    if args.locale.blank?
      puts "Usage: rake translations:merge[TO_LOCALE,FROM_LOCALE,PATH]"
      puts "eg. rake translations:merge[fr,en]"
      exit
    end
    @merge = MergeTranslation.new(:path => args.path, :from => args.default, :to => args.locale)
    puts "Merging changes in '#{args.default}.yml' into '#{args.locale}.yml' in directory #{args.path}"
    @merge.write!
  end
end