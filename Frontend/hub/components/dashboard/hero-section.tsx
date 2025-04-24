import Image from "next/image"
import { Button } from "@/components/ui/button"

interface HeroSectionProps {
  userName: string
}

export function HeroSection({ userName }: HeroSectionProps) {
  return (
    <div className="bg-theme-bg rounded-lg p-6 mb-8 dark:bg-slate-800 dark:border dark:border-slate-700">
      <div className="flex flex-col md:flex-row gap-8">
        <div className="flex-1">
          <h1 className="text-2xl font-bold mb-2 dark:text-white">
            Perfection is not attainable, but if we chase perfection we can catch excellence.
          </h1>
          <p className="text-slate-600 mb-4 dark:text-slate-400">— Vince Lombardi</p>
          <div className="mb-6">
            <p className="text-slate-700 dark:text-slate-300">Welcome back,</p>
            <p className="text-slate-700 font-medium dark:text-slate-300">{userName}!</p>
          </div>
          <Button className="bg-theme hover:bg-theme-dark text-white">Problems</Button>
        </div>
        <div className="flex-1 flex justify-center items-center">
          <Image
            src="/placeholder.svg?height=200&width=300"
            alt="Dashboard illustration"
            width={300}
            height={200}
            className="object-contain"
          />
        </div>
      </div>
    </div>
  )
}
