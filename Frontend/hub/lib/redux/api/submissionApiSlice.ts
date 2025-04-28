import { baseApiSlice } from "./baseApiSlice"
import type { SubmissionsResponse, SubmissionResponse, CreateSubmissionRequest } from "./types"

export const submissionApiSlice = baseApiSlice.injectEndpoints({
  endpoints: (builder) => ({
    getSubmissions: builder.query<SubmissionsResponse, void>({
      query: () => "/submission",
      providesTags: ["Submission"],
    }),

    getSubmissionById: builder.query<SubmissionResponse, number>({
      query: (id) => `/submission/${id}`,
      providesTags: (result, error, id) => [{ type: "Submission", id }],
    }),

    getSubmissionsByProblem: builder.query<SubmissionsResponse, number>({
      query: (problemId) => `/submission/problem?problemID=${problemId}`,
      providesTags: ["Submission"],
    }),

    createSubmission: builder.mutation<SubmissionResponse, CreateSubmissionRequest>({
      query: (data) => ({
        url: "/submission",
        method: "POST",
        body: data,
      }),
      invalidatesTags: ["Submission"],
    }),

    updateSubmission: builder.mutation<SubmissionResponse, { id: number; data: Partial<CreateSubmissionRequest> }>({
      query: ({ id, data }) => ({
        url: `/submission/${id}`,
        method: "PUT",
        body: data,
      }),
      invalidatesTags: (result, error, { id }) => [{ type: "Submission", id }],
    }),

    deleteSubmission: builder.mutation<void, number>({
      query: (id) => ({
        url: `/submission/${id}`,
        method: "DELETE",
      }),
      invalidatesTags: ["Submission"],
    }),
  }),
})

export const {
  useGetSubmissionsQuery,
  useGetSubmissionByIdQuery,
  useGetSubmissionsByProblemQuery,
  useCreateSubmissionMutation,
  useUpdateSubmissionMutation,
  useDeleteSubmissionMutation,
} = submissionApiSlice
