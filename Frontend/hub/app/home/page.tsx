import { HomeNavbar } from "@/components/home/navbar"
import { HeroSection } from "@/components/home/hero-section"
import { FeaturesSection } from "@/components/home/features-section"
import { MoreFeaturesSection } from "@/components/home/more-features-section"
import { AboutSection } from "@/components/home/about-section"
import { FAQSection } from "@/components/home/faq-section"
import { Footer } from "@/components/home/footer"

export default function HomePage() {
  return (
    <div className="min-h-screen bg-white">
      <HomeNavbar />
      <HeroSection />
      <FeaturesSection />
      <MoreFeaturesSection />
      <AboutSection />
      <FAQSection />
      <Footer />
    </div>
  )
}
