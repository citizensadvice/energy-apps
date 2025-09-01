# frozen_string_literal: true

class ImpactSurveyComponent < ViewComponent::Base
  delegate :scotland?, to: :helpers
  attr_reader :impact_survey_id

  def initialize(impact_survey_id:)
    super()
    @impact_survey_id = impact_survey_id
  end

  def render?
    impact_survey_id.present? && !scotland?
  end

  def impact_survey_uri
    URI::HTTPS.build(
      host: "www.research.net",
      path: "/r/#{@impact_survey_id}",
      query: { p: request.path }.to_query
    )
  end

  def new_tab_attributes
    title = "Take 3 minutes to tell us if you found what you needed on our website."

    {
      target: "_blank",
      rel: "noopener",
      "aria-label": "#{title} (opens in a new tab)"
    }
  end
end
