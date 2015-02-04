module CompanyCheck

  class Client

    def company_search(search_options={})
      @company_search ||= CompanyCheck::CompanySearch.new(self)
      @company_search.get(search_options)
    end

    def director_search(search_options={})
      @director_search ||= CompanyCheck::DirectorSearch.new(self)
      @director_search.get(search_options)
    end

    def company(company_id)
      @company ||= CompanyCheck::Company.new(self)
      @company.get({id:company_id})
    end

    def company_documents(company_id)
      @company_documents ||= CompanyCheck::CompanyDocument.new(self)
      @company_documents.get({id:company_id})
    end

    def director(director_id)
      @director ||= CompanyCheck::Director.new(self)
      @director.get({id:director_id})
    end

    def document(document_id)
      @document ||= CompanyCheck::Document.new(self)
      @document.get({id:document_id})
    end

  end

  class Company < BaseCommand;end
  class Director < BaseCommand;end
  class CompanySearch < BaseCommand
    def endpoint
      "search"
    end
  end
  class DirectorSearch < BaseCommand;end
  class CompanyDocument < BaseCommand
    def endpoint
      "docs/company"
    end
  end
  class Document < BaseCommand
    def endpoint
      "docs/document"
    end
  end
end
