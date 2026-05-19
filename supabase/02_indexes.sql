-- ============================================================
-- CRM Yến Sào Vĩnh Hưng
-- FILE 02: Indexes
-- ============================================================

-- ============================================================
-- profiles
-- ============================================================

CREATE INDEX idx_profiles_email     ON profiles(email);
CREATE INDEX idx_profiles_role      ON profiles(role);
CREATE INDEX idx_profiles_is_active ON profiles(is_active);

-- ============================================================
-- teams
-- ============================================================

CREATE INDEX idx_teams_name ON teams(name);

-- ============================================================
-- team_members
-- Hai index này tối ưu cho cả 2 hướng lookup: user -> teams, team -> users
-- ============================================================

CREATE INDEX idx_team_members_team_id ON team_members(team_id);
CREATE INDEX idx_team_members_user_id ON team_members(user_id);

-- ============================================================
-- pipeline_stages
-- ============================================================

CREATE INDEX idx_pipeline_stages_sort_order ON pipeline_stages(sort_order);

-- ============================================================
-- leads
-- Nhiều index vì leads là bảng trung tâm, RLS + filter + search đều hit bảng này
-- ============================================================

CREATE INDEX idx_leads_assigned_to       ON leads(assigned_to);
CREATE INDEX idx_leads_team_id           ON leads(team_id);
CREATE INDEX idx_leads_created_by        ON leads(created_by);
CREATE INDEX idx_leads_segment           ON leads(segment);
CREATE INDEX idx_leads_is_active         ON leads(is_active);
CREATE INDEX idx_leads_email             ON leads(email);
CREATE INDEX idx_leads_phone_primary     ON leads(phone_primary);
CREATE INDEX idx_leads_created_at        ON leads(created_at DESC);

-- GIN index cho mảng product_interests – hỗ trợ query kiểu: WHERE 'raw_nest' = ANY(product_interests)
CREATE INDEX idx_leads_product_interests ON leads USING GIN(product_interests);

-- ============================================================
-- lead_tag_assignments
-- ============================================================

CREATE INDEX idx_lead_tag_assignments_lead_id ON lead_tag_assignments(lead_id);
CREATE INDEX idx_lead_tag_assignments_tag_id  ON lead_tag_assignments(tag_id);

-- ============================================================
-- lead_lists
-- ============================================================

CREATE INDEX idx_lead_lists_team_id    ON lead_lists(team_id);
CREATE INDEX idx_lead_lists_created_by ON lead_lists(created_by);

-- ============================================================
-- lead_list_members
-- ============================================================

CREATE INDEX idx_lead_list_members_list_id ON lead_list_members(list_id);
CREATE INDEX idx_lead_list_members_lead_id ON lead_list_members(lead_id);

-- ============================================================
-- opportunities
-- ============================================================

CREATE INDEX idx_opportunities_lead_id             ON opportunities(lead_id);
CREATE INDEX idx_opportunities_stage_id            ON opportunities(stage_id);
CREATE INDEX idx_opportunities_assigned_to         ON opportunities(assigned_to);
CREATE INDEX idx_opportunities_team_id             ON opportunities(team_id);
CREATE INDEX idx_opportunities_is_active           ON opportunities(is_active);
CREATE INDEX idx_opportunities_created_at          ON opportunities(created_at DESC);
CREATE INDEX idx_opportunities_expected_close_date ON opportunities(expected_close_date);

-- ============================================================
-- tasks
-- ============================================================

CREATE INDEX idx_tasks_assigned_to  ON tasks(assigned_to);
CREATE INDEX idx_tasks_team_id      ON tasks(team_id);
CREATE INDEX idx_tasks_lead_id      ON tasks(lead_id);
CREATE INDEX idx_tasks_opportunity_id ON tasks(opportunity_id);
CREATE INDEX idx_tasks_status       ON tasks(status);
CREATE INDEX idx_tasks_priority     ON tasks(priority);
CREATE INDEX idx_tasks_due_date     ON tasks(due_date);

-- Composite index cho query "công việc hôm nay/tuần này của tôi"
CREATE INDEX idx_tasks_assigned_status_due ON tasks(assigned_to, status, due_date);

-- ============================================================
-- subscriptions
-- ============================================================

CREATE INDEX idx_subscriptions_lead_id        ON subscriptions(lead_id);
CREATE INDEX idx_subscriptions_opportunity_id ON subscriptions(opportunity_id);
CREATE INDEX idx_subscriptions_recorded_by    ON subscriptions(recorded_by);
CREATE INDEX idx_subscriptions_team_id        ON subscriptions(team_id);
CREATE INDEX idx_subscriptions_payment_status ON subscriptions(payment_status);
CREATE INDEX idx_subscriptions_payment_date   ON subscriptions(payment_date DESC);

-- ============================================================
-- activity_logs
-- ============================================================

CREATE INDEX idx_activity_logs_user_id              ON activity_logs(user_id);
CREATE INDEX idx_activity_logs_entity               ON activity_logs(entity_type, entity_id);
CREATE INDEX idx_activity_logs_created_at           ON activity_logs(created_at DESC);
