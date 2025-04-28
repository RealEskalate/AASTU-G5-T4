import Image from "next/image"
import { Button } from "@/components/ui/button"

interface HeroSectionProps {
  userName: string
}

export function HeroSection({ userName }: HeroSectionProps) {
  return (
    <div className="bg-theme-bg rounded-lg p-6 mb-8 dark:bg-slate-800 dark:border dark:border-slate-700 relative overflow-hidden">
      <div className="flex flex-col md:flex-row gap-8 relative z-10">
        <div className="flex-1">
          <h1 className="text-2xl font-bold mb-2 dark:text-white">Be the change that you want to see in the world.</h1>
          <p className="text-slate-600 mb-4 dark:text-slate-400">— Mahatma Gandhi</p>
          <div className="mb-6">
            <p className="text-slate-700 dark:text-slate-300">Welcome back,</p>
            <p className="text-slate-700 font-medium dark:text-slate-300">{userName}!</p>
          </div>
          <Button className="bg-theme hover:bg-theme-dark text-white">Problems</Button>
        </div>
        <div className="flex-1 flex justify-center items-center">
          <div className="relative w-full h-40 md:h-auto">
            <Image src="/images/home-illustration.png" alt="Dashboard illustration" fill className="object-contain" />
          </div>
        </div>
      </div>
      <div className="absolute top-6 right-6 text-sm text-slate-500 dark:text-slate-400">NO NEW EVENT</div>
    </div>
  )
}
