import Image from "next/image"

export function ProfileHeader({ userData, colorPreset }: { userData: any; colorPreset: string }) {
  const getHeaderBgClass = () => {
    switch (colorPreset) {
      case "purple":
        return "bg-purple-800 dark:bg-purple-900"
      case "blue":
        return "bg-blue-800 dark:bg-blue-900"
      case "orange":
        return "bg-orange-800 dark:bg-orange-900"
      case "red":
        return "bg-red-800 dark:bg-red-900"
      case "indigo":
        return "bg-indigo-800 dark:bg-indigo-900"
      default:
        return "bg-teal-800 dark:bg-teal-900"
    }
  }

  return (
    <div className={`${getHeaderBgClass()} rounded-lg overflow-hidden mb-8`}>
      <div className="pt-16 pb-6 px-6 relative">
        <div className="absolute bottom-0 left-1/2 transform -translate-x-1/2 translate-y-1/2 md:left-6 md:transform-none md:translate-x-0">
          <div className="h-20 w-20 rounded-full border-4 border-white dark:border-slate-800 overflow-hidden">
            <Image src={userData.AvatarURL || "/images/profile-pic.png"} alt="Profile" width={80} height={80} className="object-cover" />
          </div>
        </div>
        <div className="mt-10 text-center md:mt-0 md:ml-24 md:text-left text-white">
          <h1 className="text-xl font-bold">{userData.name}</h1>
          <div className="flex items-center justify-center md:justify-start gap-2">
            <span>{userData.title}</span>
            <span className="inline-flex items-center px-2 py-0.5 rounded text-xs font-medium bg-green-500 text-white">
              online
            </span>
          </div>
        </div>
      </div>
    </div>
  )
}
