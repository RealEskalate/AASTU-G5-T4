import type React from "react"
import { Linkedin, MessageCircle, Github, BarChart2, Award } from "lucide-react"

interface ProfileLink {
  platform: string
  url: string
  icon: React.ReactNode
}

interface ProfileLinksProps {
  links: ProfileLink[]
}

export function ProfileLinks({ links }: ProfileLinksProps) {
  const getIcon = (platform: string) => {
    switch (platform.toLowerCase()) {
      case "linkedin":
        return <Linkedin className="h-5 w-5 text-[#0077B5]" />
      case "telegram":
        return <MessageCircle className="h-5 w-5 text-[#0088cc]" />
      case "leetcode":
        return <Award className="h-5 w-5 text-[#FFA116]" />
      case "codeforces":
        return <BarChart2 className="h-5 w-5 text-[#1F8ACB]" />
      case "hackerrank":
        return <Award className="h-5 w-5 text-[#00EA64]" />
      case "github":
        return <Github className="h-5 w-5 text-[#333] dark:text-[#f0f6fc]" />
      default:
        return <Award className="h-5 w-5 text-slate-500" />
    }
  }

  return (
    <div className="bg-white rounded-lg shadow-sm p-4 dark:bg-slate-800 dark:border dark:border-slate-700">
      <h2 className="text-lg font-semibold mb-4 dark:text-white">Links</h2>
      <div className="space-y-3">
        {links.map((link, index) => (
          <a
            key={index}
            href={link.url}
            target="_blank"
            rel="noopener noreferrer"
            className="flex items-center gap-2 text-slate-700 hover:text-slate-900 dark:text-slate-300 dark:hover:text-white"
          >
            {getIcon(link.platform)}
            <span>{link.platform}</span>
            <span className="text-xs text-slate-500 dark:text-slate-400 truncate flex-1">{link.url}</span>
          </a>
        ))}
      </div>
    </div>
  )
}
