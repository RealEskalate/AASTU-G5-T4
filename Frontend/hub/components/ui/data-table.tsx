import type { ReactNode } from "react"

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
