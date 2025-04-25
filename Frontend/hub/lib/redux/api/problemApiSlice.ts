import { baseApiSlice } from "./baseApiSlice"
import type { Problem, ProblemsResponse, CreateProblemRequest, BaseResponse } from "./types"

export const problemApiSlice = baseApiSlice.injectEndpoints({
  endpoints: (builder) => ({
    getProblems: builder.query<Problem[], { tag?: string; name?: string }>({
      query: (params) => {
        const queryParams = new URLSearchParams()
        if (params.tag) queryParams.append("tag", params.tag)
        if (params.name) queryParams.append("name", params.name)

        return {
          url: "/problem",
          params: queryParams,
        }
      },
      transformResponse: (response: ProblemsResponse) => response.problems || [],
      providesTags: ["Problem"],
    }),

    getProblemById: builder.query<Problem, number>({
      query: (id) => `/problem/${id}`,
      transformResponse: (response: { problem: Problem }) => response.problem,
      providesTags: (result, error, id) => [{ type: "Problem", id }],
    }),

    createProblem: builder.mutation<Problem, CreateProblemRequest>({
      query: (data) => ({
        url: "/problem",
        method: "POST",
        body: data,
      }),
      transformResponse: (response: BaseResponse<Problem>) => response.data as Problem,
      invalidatesTags: ["Problem"],
    }),

    updateProblem: builder.mutation<Problem, { id: number; data: Partial<Problem> }>({
      query: ({ id, data }) => ({
        url: `/problem/${id}`,
        method: "PUT",
        body: data,
      }),
      transformResponse: (response: BaseResponse<Problem>) => response.data as Problem,
      invalidatesTags: (result, error, { id }) => [{ type: "Problem", id }],
    }),

    deleteProblem: builder.mutation<void, number>({
      query: (id) => ({
        url: `/problem/${id}`,
        method: "DELETE",
      }),
      invalidatesTags: ["Problem"],
    }),
  }),
})

export const {
  useGetProblemsQuery,
  useGetProblemByIdQuery,
  useCreateProblemMutation,
  useUpdateProblemMutation,
  useDeleteProblemMutation,
} = problemApiSlice
