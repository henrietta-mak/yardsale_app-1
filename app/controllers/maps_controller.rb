class MapsController < ApplicationController
  def index
    @information = []
    @addresses = []
    current_user.relationships.each do |relationship|
      @addresses.append(relationship.yardsale.address)
      @information.append(relationship.yardsale.title                           + "\n" +
                          relationship.yardsale.address.street                  + ", " +
                          relationship.yardsale.address.city                    + ", " +
                          relationship.yardsale.address.state                   + ", " +
                          relationship.yardsale.address.zip_code.to_s           + "\n" +
                          relationship.yardsale.date.strftime("%b %d, %Y (%A)") + "\n" +
                          relationship.yardsale.begin_time.strftime("%I:%M %p") + " - "+
                          relationship.yardsale.end_time.strftime("%I:%M %p"))
    end
    @count = @addresses.count
    @addresses = @addresses.to_json
    @information = @information.to_json
  end

  def show
    @yardsale = Yardsale.find_by_id(params[:id])
    @information = (@yardsale.title                           + "\n" +
                    @yardsale.address.street                  + ", " +
                    @yardsale.address.city                    + ", " +
                    @yardsale.address.state                   + ", " +
                    @yardsale.address.zip_code.to_s           + "\n" +
                    @yardsale.date.strftime("%b %d, %Y (%A)") + "\n" +
                    @yardsale.begin_time.strftime("%I:%M %p") + " - "+
                    @yardsale.end_time.strftime("%I:%M %p")).to_json
end
end
