# frozen_string_literal: true

module FooterHelper
  def public_website_footer_nav_links
    [
      {
        title: "Advice",
        links: advice_links
      },
      {
        title: "Resources and tools",
        links: [
          { title: "Adviser resources", url: "/about-us/adviser-resources/" },
          { title: "Education resources", url: "/about-us/how-we-provide-advice/our-prevention-work/education/" },
          { title: "Site search", url: "/s" }
        ]
      },
      {
        title: "More from us",
        links: [
          { title: "About us", url: "/about-us/" },
          { title: "Contact us", url: "/about-us/contact-us/contact-us/contact-us/" },
          { title: "Support us", url: "/about-us/support-us/" },
          { title: "Annual reports", url: "/about-us/our-work/annual-reports/" },
          { title: "Complaints", url: "/about-us/contact-us/contact-us/make-a-complaint-about-us/" },
          { title: "Media", url: "/about-us/about-us1/media/" },
          { title: "Modern slavery statement", url: "/about-us/modern-slavery-statement/" },
          { title: "Policy research", url: "/about-us/policy/" },
          { title: "Volunteering", url: "/about-us/support-us/volunteering/" },
          { title: "Jobs", url: "/about-us/job-and-voluntary-opportunities/" }
        ]
      },
      {
        title: "About this site",
        links: [
          { title: "Accessibility statement", url: "/resources-and-tools/about-this-site/accessibility/" },
          { title: "Terms and conditions", url: "/resources-and-tools/about-this-site/terms-and-conditions/" },
          { title: "Privacy and cookies", url: "/about-us/citizens-advice-privacy-policy/" }
        ]
      }
    ]
  end

  def scotland_public_website_footer_nav_links
    [
      {
        title: "Advice",
        links: advice_links
      },
      {
        title: "Resources and tools",
        links: [
          { title: "Where to get advice", url: "/scotland/about-us/get-advice-s/" },
          { title: "Template letters", url: "/scotland/consumer/template-letters/letters/" }
        ]
      },
      {
        title: "More from us",
        links: [
          { title: "More from us", url: "/scotland/about-us/" },
          { title: "Complaints", url: "https://www.cas.org.uk/about-us/feedback/complaints" },
          { title: "Campaigns", url: "https://www.cas.org.uk/our-campaigns" },
          { title: "Publications", url: "https://www.cas.org.uk/what-we-do/our-publications" },
          { title: "Support us", url: "https://www.cas.org.uk/get-involved/support-us" },
          { title: "Volunteering", url: "https://www.cas.org.uk/get-involved/work-us/volunteer-citizens-advice-bureau" }
        ]
      },
      {
        title: "About this site",
        links: [
          { title: "Accessibility statement", url: "/scotland/about-us/information/accessibility-statement-scotland/" },
          { title: "Terms and conditions", url: "/scotland/about-us/information/terms-and-conditions-scotland/" },
          { title: "Privacy", url: "https://www.cas.org.uk/data-protection-and-cookies" },
          { title: "Cookies", url: "/scotland/about-us/information/privacy-and-cookies-scotland/" }
        ]
      }
    ]
  end

  def advice_links
    return country_advice_links if current_country.blank?

    country_advice_links(country: "/#{current_country}")
  end
end
