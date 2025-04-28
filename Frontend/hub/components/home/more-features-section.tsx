"use client"

import { useEffect, useState } from "react"
import { BarChart3, Workflow, MessageSquare } from "lucide-react"
import { getThemeColor } from "@/lib/utils"

export function MoreFeaturesSection() {
  const [themeColor, setThemeColor] = useState("#10b981")

  useEffect(() => {
    setThemeColor(getThemeColor())
  }, [])

  const features = [
    {
      icon: <BarChart3 size={32} style={{ color: themeColor }} />,
      title: "Statistics",
      description:
        "Delve into Data: Harness the Power of Comprehensive Statistical Analysis to Gain Deeper Insights, Uncover Trends, and Track Performance Metrics for Informed Decision-Making and Continuous Improvement",
    },
    {
      icon: <Workflow size={32} style={{ color: themeColor }} />,
      title: "Automated Workflow",
      description:
        "Transform Your Operations and Boost Productivity with Our Automated Workflow Solutions, Allowing You to Streamline Processes, Eliminate Redundancy, and Focus on What Truly Matters.",
    },
    {
      icon: <MessageSquare size={32} style={{ color: themeColor }} />,
      title: "Forum",
      description:
        "Dive into Our Dynamic Forum Community, Where Enriching Discussions, Insightful Exchanges, and Collaborative Learning Opportunities Await. Empowering You to Engage, Learn, and Grow Together.",
    },
  ]

  return (
    <section className="py-16 md:py-24">
      <div className="container mx-auto px-4 sm:px-6 lg:px-8">
        <h2 className="text-3xl md:text-4xl font-bold text-center mb-16">More Features</h2>

        <div className="grid md:grid-cols-3 gap-8">
          {features.map((feature, index) => (
            <div key={index} className="bg-white rounded-lg shadow-md p-8 hover:shadow-lg transition-shadow">
              <div className="mb-6">{feature.icon}</div>
              <h3 className="text-xl font-bold mb-4">{feature.title}</h3>
              <p className="text-gray-600">{feature.description}</p>
            </div>
          ))}
        </div>

        <div className="text-center mt-16 text-gray-600 max-w-3xl mx-auto">
          <p>
            Continuously Enhancing Your Experience: Our Commitment to Innovation Means We're Hard at Work Developing and
            Integrating a Host of Exciting New Features. Stay Tuned for Even More Ways to Elevate Your Journey.
          </p>
        </div>
      </div>
    </section>
  )
}
