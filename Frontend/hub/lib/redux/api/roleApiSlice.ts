import { baseApiSlice } from "./baseApiSlice"
import type { Role, RolesResponse, CreateRoleRequest, BaseResponse } from "./types"

export const roleApiSlice = baseApiSlice.injectEndpoints({
  endpoints: (builder) => ({
    getRoles: builder.query<Role[], void>({
      query: () => "/role",
      transformResponse: (response: RolesResponse) => response.roles || [],
      providesTags: ["Role"],
    }),

    getRoleById: builder.query<Role, number>({
      query: (id) => `/role/${id}`,
      transformResponse: (response: BaseResponse<Role>) => response.data as Role,
      providesTags: (result, error, id) => [{ type: "Role", id }],
    }),

    createRole: builder.mutation<Role, CreateRoleRequest>({
      query: (data) => ({
        url: "/role",
        method: "POST",
        body: data,
      }),
      transformResponse: (response: BaseResponse<Role>) => response.data as Role,
      invalidatesTags: ["Role"],
    }),
  }),
})

export const { useGetRolesQuery, useGetRoleByIdQuery, useCreateRoleMutation } = roleApiSlice
