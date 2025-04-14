import type { ReactNode } from "react"
import Link from "next/link"
import { ExternalLink } from "lucide-react"

export interface Column {
  key: string
  title: string
  align?: "left" | "center" | "right"
  render?: (value: any, row: any) => ReactNode
}

interface DataTableProps {
  title?: string
  columns: Column[]
  data: any[]
  emptyMessage?: string
}

export function DataTable({ title, columns, data, emptyMessage = "No data available" }: DataTableProps) {
  return (
    <div className="bg-white rounded-lg shadow-sm p-4 dark:bg-slate-800 dark:border dark:border-slate-700">
      {title && <h2 className="text-lg font-semibold mb-4 dark:text-white">{title}</h2>}
      <div className="overflow-x-auto">
        <table className="w-full">
          <thead>
            <tr className="border-b dark:border-slate-700">
              {columns.map((column) => (
                <th
                  key={column.key}
                  className={`py-2 px-4 font-medium text-sm text-slate-600 dark:text-slate-300 ${
                    column.align === "right" ? "text-right" : column.align === "center" ? "text-center" : "text-left"
                  }`}
                >
                  {column.title}
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {data.length > 0 ? (
              data.map((row, rowIndex) => (
                <tr key={rowIndex} className={rowIndex < data.length - 1 ? "border-b dark:border-slate-700" : ""}>
                  {columns.map((column) => (
                    <td
                      key={`${rowIndex}-${column.key}`}
                      className={`py-3 px-4 dark:text-slate-300 ${
                        column.align === "right"
                          ? "text-right"
                          : column.align === "center"
                            ? "text-center"
                            : "text-left"
                      }`}
                    >
                      {column.render ? column.render(row[column.key], row) : row[column.key]}
                    </td>
                  ))}
                </tr>
              ))
            ) : (
              <tr>
                <td colSpan={columns.length} className="py-4 px-4 text-center text-slate-500 dark:text-slate-400">
                  {emptyMessage}
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  )
}

export function DifficultyBadge({ level }: { level: string }) {
  const getColor = () => {
    switch (level.toLowerCase()) {
      case "hard":
        return "bg-red-100 text-red-800 border-red-200 dark:bg-red-900/30 dark:text-red-300 dark:border-red-800"
      case "medium":
        return "bg-yellow-100 text-yellow-800 border-yellow-200 dark:bg-yellow-900/30 dark:text-yellow-300 dark:border-yellow-800"
      case "easy":
        return "bg-green-100 text-green-800 border-green-200 dark:bg-green-900/30 dark:text-green-300 dark:border-green-800"
      default:
        return "bg-slate-100 text-slate-800 border-slate-200 dark:bg-slate-700 dark:text-slate-300 dark:border-slate-600"
    }
  }

  return (
    <span className={`inline-flex items-center px-2 py-0.5 rounded text-xs font-medium ${getColor()}`}>{level}</span>
  )
}

export function ExternalLinkButton({ href }: { href: string }) {
  return (
    <Link
      href={href}
      target="_blank"
      rel="noopener noreferrer"
      className="inline-flex items-center text-blue-600 hover:text-blue-800 dark:text-blue-400 dark:hover:text-blue-300"
    >
      <ExternalLink className="h-4 w-4" />
    </Link>
  )
}
