"use client"

import { useEffect, useState } from "react"
import Image from "next/image"
import { getThemeColor } from "@/lib/utils"

export function AboutSection() {
  const [themeColor, setThemeColor] = useState("#10b981")

  useEffect(() => {
    setThemeColor(getThemeColor())
  }, [])

  return (
    <section className="py-16 md:py-24 bg-gray-50">
      <div className="container mx-auto px-4 sm:px-6 lg:px-8">
        <h2 className="text-3xl md:text-4xl font-bold text-center mb-16">
          About <span style={{ color: themeColor }}>A2SV</span>
        </h2>

        <div className="max-w-4xl mx-auto">
          <p className="text-gray-700 text-lg leading-relaxed">
            African to Silicon Valley is a non-profit organization committed to educating high-potential university
            students in Africa. We establish valuable partnerships with tech companies like <strong>Google</strong>,{" "}
            <strong>Palantir</strong>, <strong>Databricks</strong>, <strong>Bloomberg</strong>, and{" "}
            <strong>Meta</strong>, offering our students opportunities in Silicon Valley. Our free program equips
            students with problem solving skills and encourages them to address critical issues in their home countries
            using digital solutions. By removing financial barriers, we ensure that talent is not only recognized but
            also nurtured, promoting a pathway to success.
          </p>
        </div>

        <div className="mt-16 flex justify-center">
          <Image src="/images/A2SV.svg" alt="A2SV Logo" width={600} height={200} className="max-w-full h-auto" />
        </div>
      </div>
    </section>
  )
}
