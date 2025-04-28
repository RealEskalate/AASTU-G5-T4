"use client"

import { useEffect, useState } from "react"
import Image from "next/image"
import { getThemeColor } from "@/lib/utils"

export function FeaturesSection() {
  const [themeColor, setThemeColor] = useState("#10b981")

  useEffect(() => {
    setThemeColor(getThemeColor())
  }, [])

  return (
    <section className="py-16 md:py-24 bg-gray-50">
      <div className="container mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center mb-16">
          <h2 className="text-3xl md:text-4xl font-bold mb-4">
            Level up your education phase <span style={{ color: themeColor }}>a step ahead.</span>
          </h2>
          <p className="text-gray-600 text-lg max-w-3xl mx-auto">
            Elevate Your Learning Journey: Discover the Next Level of Education with Enhanced Features
          </p>
        </div>

        {/* Feature 1: Wide range pool of problems */}
        <div className="grid md:grid-cols-2 gap-8 items-center mb-24">
          <div className="order-2 md:order-1">
            <h3 className="text-2xl font-bold mb-4">Wide range pool of problems</h3>
            <p className="text-gray-600 mb-6">
              Wide pool of problems waiting for you. Wide pool of problems waiting for you.
            </p>
            <div className="bg-white rounded-lg shadow-lg p-6 overflow-hidden">
              <div className="space-y-4">
                {[1, 2, 3, 4, 5].map((i) => (
                  <div key={i} className="flex items-center border-b border-gray-100 pb-3">
                    <div
                      className={`w-16 h-6 rounded-md text-xs flex items-center justify-center text-white font-medium ${i % 2 === 0 ? "bg-yellow-500" : "bg-green-500"}`}
                    >
                      {i % 2 === 0 ? "Medium" : "Easy"}
                    </div>
                    <div className="ml-4 flex-1 font-medium text-gray-800">
                      {
                        [
                          "Plus One",
                          "Diagonal Traverse",
                          "All Divisions With the Highest Score",
                          "Image Smoother",
                          "Find the Winner",
                        ][i - 1]
                      }
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>
          <div className="order-1 md:order-2">
            <Image
              src="/images/wide-problems.png"
              alt="Wide range pool of problems"
              width={600}
              height={400}
              className="rounded-lg shadow-lg"
            />
          </div>
        </div>

        {/* Feature 2: Progress Tracker */}
        <div className="grid md:grid-cols-2 gap-8 items-center mb-24">
          <div>
            <Image
              src="/images/progress-tracker.png"
              alt="Progress Tracker"
              width={600}
              height={400}
              className="rounded-lg shadow-lg"
            />
          </div>
          <div>
            <h3 className="text-2xl font-bold mb-4">Progress Tracker</h3>
            <p className="text-gray-600 mb-6">
              Stay On Course: Effortlessly Monitor Your Journey with Our Progress Tracker Feature
            </p>
            <div className="bg-white rounded-lg shadow-lg p-6">
              <div className="flex justify-center">
                <div className="relative w-48 h-48">
                  <div className="absolute inset-0 rounded-full border-8 border-gray-100"></div>
                  <div
                    className="absolute top-0 left-0 w-48 h-48 rounded-full border-8 border-transparent border-t-8"
                    style={{
                      borderTopColor: themeColor,
                      transform: "rotate(45deg)",
                    }}
                  ></div>
                  <div className="absolute inset-0 flex items-center justify-center flex-col">
                    <div className="text-sm text-gray-500">Problems</div>
                    <div className="text-3xl font-bold">419</div>
                  </div>
                </div>
              </div>
              <div className="mt-6 grid grid-cols-2 gap-4">
                <div className="flex items-center">
                  <div className="w-3 h-3 rounded-full bg-green-500 mr-2"></div>
                  <span className="text-sm">Solved: 49 Problems</span>
                </div>
                <div className="flex items-center">
                  <div className="w-3 h-3 rounded-full bg-gray-300 mr-2"></div>
                  <span className="text-sm">Available: 370 Problems</span>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Feature 3: Comprehensive Roadmap */}
        <div className="grid md:grid-cols-2 gap-8 items-center mb-24">
          <div className="order-2 md:order-1">
            <h3 className="text-2xl font-bold mb-4">Comprehensive Roadmap</h3>
            <p className="text-gray-600 mb-6">
              Chart Your Course: Navigating Success Through Our Comprehensive Roadmap Feature.
            </p>
            <div className="bg-white rounded-lg shadow-lg p-6">
              <div className="mb-4 p-4 rounded-lg bg-yellow-50 border border-yellow-100">
                <div className="flex items-center">
                  <div className="w-8 h-8 rounded-full bg-yellow-200 flex items-center justify-center text-yellow-700 font-bold text-xs mr-3">
                    M
                  </div>
                  <div>
                    <div className="font-medium">
                      Math <span className="text-xs text-gray-500">(Recommended)</span>
                    </div>
                    <div className="text-xs text-gray-600 mt-1">
                      Embark on a journey of mathematical wonders, where numbers dance and equations weave the fabric of
                      the universe.
                    </div>
                  </div>
                </div>
              </div>
              <div className="space-y-3">
                <div className="flex items-center">
                  <div className="w-6 h-6 rounded-full bg-yellow-100 flex items-center justify-center text-yellow-700 font-bold text-xs mr-3">
                    A
                  </div>
                  <div className="font-medium">Array</div>
                </div>
                <div className="flex items-center">
                  <div className="w-6 h-6 rounded-full bg-yellow-100 flex items-center justify-center text-yellow-700 font-bold text-xs mr-3">
                    S
                  </div>
                  <div className="font-medium">String</div>
                </div>
                <div className="flex items-center">
                  <div className="w-6 h-6 rounded-full bg-yellow-100 flex items-center justify-center text-yellow-700 font-bold text-xs mr-3">
                    S
                  </div>
                  <div className="font-medium">Sorting</div>
                </div>
              </div>
            </div>
          </div>
          <div className="order-1 md:order-2">
            <Image
              src="/images/comprehensive-roadmap.png"
              alt="Comprehensive Roadmap"
              width={600}
              height={400}
              className="rounded-lg shadow-lg"
            />
          </div>
        </div>

        {/* Feature 4: Contest Ratings */}
        <div className="grid md:grid-cols-2 gap-8 items-center">
          <div>
            <Image
              src="/images/contest-ratings.png"
              alt="Contest Ratings"
              width={600}
              height={400}
              className="rounded-lg shadow-lg"
            />
          </div>
          <div>
            <h3 className="text-2xl font-bold mb-4">Contest Ratings</h3>
            <p className="text-gray-600 mb-6">
              Evaluate and Excel: Harness the Power of Contest Ratings for Continuous Improvement.
            </p>
            <div className="bg-white rounded-lg shadow-lg p-6">
              <div className="space-y-4">
                {[
                  { name: "Kenenisa Alemayehu", role: "G5C Head", score: 2256 },
                  { name: "Abel Ayalew", role: "G47 Student", score: 2168 },
                  { name: "Simon Gebrehiwot Weldearegay", role: "G5B Head", score: 1902 },
                ].map((person, i) => (
                  <div key={i} className="flex items-center justify-between">
                    <div className="flex items-center">
                      <div className="w-10 h-10 rounded-full bg-gray-200 flex items-center justify-center text-gray-700 font-bold text-xs mr-3">
                        {person.name.charAt(0)}
                      </div>
                      <div>
                        <div className="font-medium">{person.name}</div>
                        <div className="text-xs text-gray-500">{person.role}</div>
                      </div>
                    </div>
                    <div className="font-bold">{person.score}</div>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  )
}
