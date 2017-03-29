require 'csv'

class CsvExportService
  def initialize(object)
    @object = object
  end

  def export
    case @object
      when Donation::ActiveRecord_AssociationRelation
        Donations::CsvExportService.new(@object).export
      when Volunteer::ActiveRecord_AssociationRelation
        Volunteers::CsvExportService.new(@object).export
      else
        raise "CsvExportService does not know how to handle object of type #{@object.class}"
    end
  end
end
