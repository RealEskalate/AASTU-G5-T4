import { baseApiSlice } from "./baseApiSlice"
import type { Group, GroupsResponse, CreateGroupRequest } from "./types"

export const groupApiSlice = baseApiSlice.injectEndpoints({
  endpoints: (builder) => ({
    getGroups: builder.query<Group[], void>({
      query: () => "/group",
      transformResponse: (response: { groups: any[] }) =>
        response.groups.map((group) => ({
          id: group.ID,
          name: group.Name,
          code: group.ShortName,
          members: 0, // Placeholder as the API doesn't provide member count
          timeSpent: "N/A", // Placeholder as the API doesn't provide this data
          avgRating: "N/A", // Placeholder as the API doesn't provide this data
        })),
      providesTags: ["Group"],
    }),

    getGroupById: builder.query<Group, number>({
      query: (id) => `/group/${id}`,
      transformResponse: (response: { group: Group }) => response.group,
      providesTags: (result, error, id) => [{ type: "Group", id }],
    }),

    createGroup: builder.mutation<Group, CreateGroupRequest>({
      query: (data) => ({
        url: "/group",
        method: "POST",
        body: data,
      }),
      transformResponse: (response: { group: Group }) => response.group,
      invalidatesTags: ["Group"],
    }),

    updateGroup: builder.mutation<Group, { id: number; data: Partial<CreateGroupRequest> }>({
      query: ({ id, data }) => ({
        url: `/group/${id}`,
        method: "PUT",
        body: data,
      }),
      transformResponse: (response: { group: Group }) => response.group,
      invalidatesTags: (result, error, { id }) => [{ type: "Group", id }],
    }),

    deleteGroup: builder.mutation<void, number>({
      query: (id) => ({
        url: `/group/${id}`,
        method: "DELETE",
      }),
      invalidatesTags: ["Group"],
    }),
  }),
})

export const {
  useGetGroupsQuery,
  useGetGroupByIdQuery,
  useCreateGroupMutation,
  useUpdateGroupMutation,
  useDeleteGroupMutation,
} = groupApiSlice
