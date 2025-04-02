import Link from "next/link"
import { ExternalLink } from "lucide-react"

export default function SessionCountdown() {
  return (
    <div className="bg-white rounded-lg p-4 shadow-sm border">
      <h3 className="font-semibold mb-1">String Session</h3>
      <p className="text-sm text-gray-500 mb-4">Event Coming up-undefined</p>

      <div className="flex justify-between text-center mb-4">
        <div>
          <div className="text-3xl font-semibold text-blue-600">0</div>
          <div className="text-xs text-gray-500">Days</div>
        </div>
        <div className="text-xl font-semibold">:</div>
        <div>
          <div className="text-3xl font-semibold text-blue-600">03</div>
          <div className="text-xs text-gray-500">Hours</div>
        </div>
        <div className="text-xl font-semibold">:</div>
        <div>
          <div className="text-3xl font-semibold text-blue-600">12</div>
          <div className="text-xs text-gray-500">Minutes</div>
        </div>
        <div className="text-xl font-semibold">:</div>
        <div>
          <div className="text-3xl font-semibold text-blue-600">20</div>
          <div className="text-xs text-gray-500">Seconds</div>
        </div>
      </div>

      <div className="flex justify-end">
        <Link href="#" className="text-blue-600 font-medium text-sm flex items-center gap-1">
          LINK <ExternalLink size={14} />
        </Link>
      </div>
    </div>
  )
}

