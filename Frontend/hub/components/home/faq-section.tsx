"use client"

import { useState, useEffect } from "react"
import { ChevronDown, ChevronUp } from "lucide-react"
import { getThemeColor } from "@/lib/utils"

type FAQItem = {
  question: string
  answer: string
}

export function FAQSection() {
  const [themeColor, setThemeColor] = useState("#10b981")
  const [openIndex, setOpenIndex] = useState<number | null>(0)

  useEffect(() => {
    setThemeColor(getThemeColor())
  }, [])

  const faqs: FAQItem[] = [
    {
      question: "Who can use A2SV Hub?",
      answer:
        "To access the A2SV Hub, participation in the A2SV Education program is a prerequisite. Our platform is purposefully designed as an internal tool tailored exclusively for educating our students within the A2SV Education framework. Currently, it is not intended for public use. As we prioritize the needs and progress of our enrolled students, we continuously refine and enhance the A2SV Hub to meet the evolving demands of our educational initiatives.",
    },
    {
      question: "How to join A2SV?",
      answer:
        "To join A2SV, simply visit our official website at a2sv.org. While A2SV is open to everyone, it particularly welcomes university students. Explore our website to learn more about our mission, programs, and opportunities for involvement. We look forward to welcoming you to our community!",
    },
    {
      question: "How to register for A2SV Hub?",
      answer:
        "If you're a member of A2SV, expect to receive an invitation directly to your email inbox. Should you find yourself without access, kindly reach out to your department heads for assistance. Your prompt communication ensures swift resolution, granting you entry to our exclusive educational platform, the A2SV Hub, where learning and collaboration thrive.",
    },
    {
      question: "How does the hub work?",
      answer:
        "At the core of the A2SV Hub lies a powerful relational database that serves as the foundation for organizing our data. Leveraging this structure, we develop various features and automations tailored to streamline your experience. These functionalities are meticulously crafted to simplify tasks, enhance efficiency, and ultimately make your educational journey smoother. By harnessing the capabilities of our database and layering on intelligent automations, the A2SV Hub empowers you to navigate your academic endeavors with ease and precision.",
    },
  ]

  const toggleFAQ = (index: number) => {
    setOpenIndex(openIndex === index ? null : index)
  }

  return (
    <section className="py-16 md:py-24">
      <div className="container mx-auto px-4 sm:px-6 lg:px-8">
        <h2 className="text-3xl md:text-4xl font-bold text-center mb-16">FAQ</h2>

        <div className="max-w-3xl mx-auto">
          {faqs.map((faq, index) => (
            <div key={index} className="mb-4">
              <button
                className="w-full flex items-center justify-between bg-white p-6 rounded-lg shadow-sm hover:shadow-md transition-shadow text-left"
                onClick={() => toggleFAQ(index)}
              >
                <h3 className="text-lg font-medium">{faq.question}</h3>
                {openIndex === index ? (
                  <ChevronUp size={20} style={{ color: themeColor }} />
                ) : (
                  <ChevronDown size={20} style={{ color: themeColor }} />
                )}
              </button>
              {openIndex === index && (
                <div className="bg-white p-6 rounded-b-lg shadow-sm mt-1">
                  <p className="text-gray-700">{faq.answer}</p>
                </div>
              )}
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}
