"use client"

import { useEffect, useState } from "react"
import Link from "next/link"
import { Facebook, Twitter, Instagram } from "lucide-react"
import { getThemeColor } from "@/lib/utils"

export function Footer() {
  const [themeColor, setThemeColor] = useState("#10b981")

  useEffect(() => {
    setThemeColor(getThemeColor())
  }, [])

  return (
    <footer className="bg-gray-50 py-12 md:py-16">
      <div className="container mx-auto px-4 sm:px-6 lg:px-8">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
          {/* Logo and Description */}
          <div className="md:col-span-1">
            <div className="flex items-center mb-4">
              <div className="w-8 h-8 mr-2 relative">
                <div className="absolute inset-0 rounded-md border-2" style={{ borderColor: themeColor }}></div>
                <div
                  className="absolute inset-1 flex items-center justify-center text-white font-bold text-xs"
                  style={{ color: themeColor }}
                >
                  A2
                </div>
              </div>
              <span className="text-xl font-bold" style={{ color: themeColor }}>
                HUB
              </span>
            </div>
            <p className="text-gray-600 text-sm">
              Elevating Education, One Feature at a Time -Welcome to the A2SV Hub.
            </p>
          </div>

          {/* A2SV Hub Links */}
          <div>
            <h3 className="font-semibold mb-4" style={{ color: themeColor }}>
              A2SV Hub
            </h3>
            <ul className="space-y-2">
              <li>
                <Link href="/blog" className="text-gray-600 hover:text-gray-800">
                  Blog
                </Link>
              </li>
              <li>
                <Link href="/docs" className="text-gray-600 hover:text-gray-800">
                  Docs
                </Link>
              </li>
            </ul>
          </div>

          {/* A2SV Links */}
          <div>
            <h3 className="font-semibold mb-4" style={{ color: themeColor }}>
              A2SV
            </h3>
            <ul className="space-y-2">
              <li>
                <Link href="/about" className="text-gray-600 hover:text-gray-800">
                  Our Story
                </Link>
              </li>
              <li>
                <Link href="/join" className="text-gray-600 hover:text-gray-800">
                  Join A2SV
                </Link>
              </li>
              <li>
                <Link href="/projects" className="text-gray-600 hover:text-gray-800">
                  Projects
                </Link>
              </li>
            </ul>
          </div>

          {/* Social Links */}
          <div>
            <h3 className="font-semibold mb-4" style={{ color: themeColor }}>
              Follow Us
            </h3>
            <div className="flex space-x-4">
              <Link href="#" className="text-gray-600 hover:text-gray-800">
                <Facebook size={20} />
              </Link>
              <Link href="#" className="text-gray-600 hover:text-gray-800">
                <Twitter size={20} />
              </Link>
              <Link href="#" className="text-gray-600 hover:text-gray-800">
                <Instagram size={20} />
              </Link>
            </div>
          </div>
        </div>

        <div className="border-t border-gray-200 mt-12 pt-8 text-center text-sm text-gray-600">
          <p>&copy; {new Date().getFullYear()} A2SV Hub. All rights reserved.</p>
        </div>
      </div>
    </footer>
  )
}
