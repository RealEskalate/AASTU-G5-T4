"use client"

import { useEffect, useState } from "react"
import Image from "next/image"
import { Button } from "@/components/ui/button"
import { ArrowRight } from "lucide-react"
import { getThemeColor } from "@/lib/utils"

export function HeroSection() {
  const [themeColor, setThemeColor] = useState("#10b981")

  useEffect(() => {
    setThemeColor(getThemeColor())
  }, [])

  return (
    <section className="pt-24 pb-16 md:pt-32 md:pb-24 relative overflow-hidden">
      {/* Background pattern */}
      <div className="absolute inset-0 z-0">
        <svg width="100%" height="100%" viewBox="0 0 100 100" preserveAspectRatio="none" className="opacity-10">
          <path d="M0,0 Q50,50 100,0 V100 H0 Z" fill="none" stroke={themeColor} strokeWidth="0.5" />
          <path d="M0,100 Q50,50 100,100 V0 H0 Z" fill="none" stroke={themeColor} strokeWidth="0.5" />
        </svg>
      </div>

      <div className="container mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        <div className="text-center max-w-4xl mx-auto">
          <h1 className="text-3xl md:text-5xl font-bold mb-6 leading-tight">
            No more jumbling in sheets, focus on your code,
            <br />
            we'll keep track of <span style={{ color: themeColor }}>everything</span>.
          </h1>
          <p className="text-gray-700 text-lg md:text-xl mb-10 max-w-3xl mx-auto">
            Empower Collaboration and Efficiency: Experience Seamless Educational Endeavors with the A2SV Hub, Your
            Centralized Solution for Streamlining Organization, Collaboration, and Knowledge Sharing.
          </p>
          <Button className="rounded-full px-8 py-6 text-lg font-medium" style={{ backgroundColor: themeColor }}>
            Get Started Now <ArrowRight className="ml-2 h-5 w-5" />
          </Button>
        </div>

        <div className="mt-16 md:mt-24 relative">
          <div className="rounded-lg overflow-hidden shadow-xl border border-gray-200">
            <Image
              src="/images/safari-browser.svg"
              alt="A2SV Hub Dashboard"
              width={1200}
              height={675}
              className="w-full"
            />
          </div>
        </div>
      </div>
    </section>
  )
}
