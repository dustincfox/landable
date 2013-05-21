require_dependency "landable/application_controller"

module Landable
  module Api
    class PagesController < ApplicationController
      def index
        if params[:directory].blank?
          head :bad_request
          return
        end

        listing = Directory.listing(params[:directory])
        if listing.empty?
          head :not_found
          return
        end

        render json: listing
      end

      def create
        @page = Page.new page_params
        @page.save!
        render json: @page, serializer: Landable::PageSerializer, status: :created, location: url_for(@page)
      end

      def show
        @page = Page.find params[:id]
        render json: @page, serializer: Landable::PageSerializer
      end

      private

      def page_params
        params.require(:page).permit(:id, :title, :body)
      end
    end
  end
end