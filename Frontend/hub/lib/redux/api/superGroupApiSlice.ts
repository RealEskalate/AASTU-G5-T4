import { baseApiSlice } from "./baseApiSlice"
import type { SuperGroup, SuperGroupsResponse, CreateSuperGroupRequest, BaseResponse } from "./types"

export const superGroupApiSlice = baseApiSlice.injectEndpoints({
  endpoints: (builder) => ({
    getSuperGroups: builder.query<SuperGroup[], void>({
      query: () => "/supergroup",
      transformResponse: (response: SuperGroupsResponse) => response.supergroups || [],
      providesTags: ["SuperGroup"],
    }),

    getSuperGroupById: builder.query<SuperGroup, number>({
      query: (id) => `/supergroup/${id}`,
      transformResponse: (response: BaseResponse<SuperGroup>) => response.data as SuperGroup,
      providesTags: (result, error, id) => [{ type: "SuperGroup", id }],
    }),

    getSuperGroupByName: builder.query<SuperGroup[], string>({
      query: (name) => `/supergroup/search?name=${name}`,
      transformResponse: (response: SuperGroupsResponse) => response.supergroups || [],
      providesTags: ["SuperGroup"],
    }),

    createSuperGroup: builder.mutation<SuperGroup, CreateSuperGroupRequest>({
      query: (data) => ({
        url: "/supergroup",
        method: "POST",
        body: data,
      }),
      transformResponse: (response: BaseResponse<SuperGroup>) => response.data as SuperGroup,
      invalidatesTags: ["SuperGroup"],
    }),

    updateSuperGroup: builder.mutation<SuperGroup, { id: number; data: CreateSuperGroupRequest }>({
      query: ({ id, data }) => ({
        url: `/supergroup/${id}`,
        method: "PUT",
        body: data,
      }),
      transformResponse: (response: BaseResponse<SuperGroup>) => response.data as SuperGroup,
      invalidatesTags: (result, error, { id }) => [{ type: "SuperGroup", id }],
    }),

    deleteSuperGroup: builder.mutation<void, number>({
      query: (id) => ({
        url: `/supergroup/${id}`,
        method: "DELETE",
      }),
      invalidatesTags: ["SuperGroup"],
    }),
  }),
})

export const {
  useGetSuperGroupsQuery,
  useGetSuperGroupByIdQuery,
  useGetSuperGroupByNameQuery,
  useCreateSuperGroupMutation,
  useUpdateSuperGroupMutation,
  useDeleteSuperGroupMutation,
} = superGroupApiSlice
