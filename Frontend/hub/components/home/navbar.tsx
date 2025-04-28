"use client"

import { useState, useEffect } from "react"
import Link from "next/link"
import { Menu } from "lucide-react"
import { Button } from "@/components/ui/button"
import { getThemeColor } from "@/lib/utils"
import { LoginDropdown } from "@/components/home/login-dropdown"

export function HomeNavbar() {
  const [isScrolled, setIsScrolled] = useState(false)
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false)
  const [themeColor, setThemeColor] = useState("#10b981")
  const [loginDropdownOpen, setLoginDropdownOpen] = useState(false)

  useEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 10)
    }

    setThemeColor(getThemeColor())
    window.addEventListener("scroll", handleScroll)
    return () => window.removeEventListener("scroll", handleScroll)
  }, [])

  const handleLoginClick = () => {
    setLoginDropdownOpen(!loginDropdownOpen)
  }

  return (
    <header
      className={`fixed top-0 left-0 right-0 z-50 transition-all duration-300 ${
        isScrolled ? "bg-white/90 backdrop-blur-md shadow-sm" : "bg-transparent"
      }`}
    >
      <div className="container mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between h-16 md:h-20">
          {/* Logo */}
          <div className="flex items-center">
            <Link href="/home" className="flex items-center">
              <div className="flex items-center">
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
            </Link>
          </div>

          {/* Desktop Navigation */}
          <nav className="hidden md:flex items-center space-x-8">
            <Link href="/home" className="text-gray-800 hover:text-gray-600 font-medium">
              Home
            </Link>
            <Link href="/docs" className="text-gray-800 hover:text-gray-600 font-medium">
              Docs
            </Link>
            <Link href="/blog" className="text-gray-800 hover:text-gray-600 font-medium">
              Blog
            </Link>
            <Link href="/about" className="text-gray-800 hover:text-gray-600 font-medium">
              About A2SV
            </Link>
          </nav>

          {/* Login Button */}
          <div className="hidden md:block relative">
            <Button className="rounded-full px-6" style={{ backgroundColor: themeColor }} onClick={handleLoginClick}>
              Login
            </Button>
            <LoginDropdown isOpen={loginDropdownOpen} onClose={() => setLoginDropdownOpen(false)} />
          </div>

          {/* Mobile Menu Button */}
          <div className="md:hidden">
            <button type="button" className="text-gray-800" onClick={() => setMobileMenuOpen(!mobileMenuOpen)}>
              <Menu size={24} />
            </button>
          </div>
        </div>
      </div>

      {/* Mobile Menu */}
      {mobileMenuOpen && (
        <div className="md:hidden bg-white shadow-lg">
          <div className="px-4 pt-2 pb-4 space-y-3">
            <Link href="/home" className="block py-2 text-gray-800 hover:text-gray-600 font-medium">
              Home
            </Link>
            <Link href="/docs" className="block py-2 text-gray-800 hover:text-gray-600 font-medium">
              Docs
            </Link>
            <Link href="/blog" className="block py-2 text-gray-800 hover:text-gray-600 font-medium">
              Blog
            </Link>
            <Link href="/about" className="block py-2 text-gray-800 hover:text-gray-600 font-medium">
              About A2SV
            </Link>
            <Button className="w-full rounded-full" style={{ backgroundColor: themeColor }} onClick={handleLoginClick}>
              Login
            </Button>
          </div>
        </div>
      )}
    </header>
  )
}
